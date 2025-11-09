# Manual migration for workspace isolation

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('account_v2', '0002_user_auth_provider'),
    ]

    operations = [
        # Create UserWorkspace model
        migrations.CreateModel(
            name='UserWorkspace',
            fields=[
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('modified_at', models.DateTimeField(auto_now=True)),
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('workspace_id', models.CharField(max_length=255, unique=True)),
                ('is_active', models.BooleanField(default=True)),
                ('organization', models.ForeignKey(db_comment='Organization this workspace belongs to', on_delete=models.deletion.CASCADE, related_name='user_workspaces', to='account_v2.organization')),
                ('user', models.OneToOneField(db_comment='User who owns this workspace', on_delete=models.deletion.CASCADE, related_name='workspace', to='account_v2.user')),
            ],
            options={
                'verbose_name': 'User Workspace',
                'verbose_name_plural': 'User Workspaces',
                'db_table': 'user_workspace',
            },
        ),
        migrations.AddConstraint(
            model_name='userworkspace',
            constraint=models.UniqueConstraint(fields=('user', 'organization'), name='unique_user_workspace_per_org'),
        ),
        
        # Add workspace_id to existing models
        migrations.RunSQL(
            "ALTER TABLE unstract.prompt_studio_registry ADD COLUMN workspace_id VARCHAR(255);",
            reverse_sql="ALTER TABLE unstract.prompt_studio_registry DROP COLUMN workspace_id;"
        ),
        migrations.RunSQL(
            "ALTER TABLE unstract.api_deployment ADD COLUMN workspace_id VARCHAR(255);",
            reverse_sql="ALTER TABLE unstract.api_deployment DROP COLUMN workspace_id;"
        ),
        migrations.RunSQL(
            "ALTER TABLE unstract.custom_tool ADD COLUMN workspace_id VARCHAR(255);",
            reverse_sql="ALTER TABLE unstract.custom_tool DROP COLUMN workspace_id;"
        ),
        migrations.RunSQL(
            "ALTER TABLE unstract.workflow ADD COLUMN workspace_id VARCHAR(255);",
            reverse_sql="ALTER TABLE unstract.workflow DROP COLUMN workspace_id;"
        ),
    ]