# Generated manually to add organization field to WorkflowExecution

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("account_v2", "0001_initial"),
        ("workflow_v2", "0017_workflow_shared_to_org_workflow_shared_users"),
    ]

    operations = [
        migrations.AddField(
            model_name="workflowexecution",
            name="organization",
            field=models.ForeignKey(
                blank=True,
                db_comment="Foreign key reference to the Organization model.",
                default=None,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                to="account_v2.organization",
            ),
        ),
    ]