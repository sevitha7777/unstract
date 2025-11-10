# Generated manually to populate organization field in WorkflowExecution

from django.db import migrations


def populate_organization_field(apps, schema_editor):
    """Populate organization field for existing WorkflowExecution records."""
    WorkflowExecution = apps.get_model("workflow_v2", "WorkflowExecution")
    
    # Update all WorkflowExecution records to have the same organization as their workflow
    for execution in WorkflowExecution.objects.select_related("workflow").all():
        if execution.workflow and execution.workflow.organization:
            execution.organization = execution.workflow.organization
            execution.save(update_fields=["organization"])


def reverse_populate_organization_field(apps, schema_editor):
    """Reverse migration - clear organization field."""
    WorkflowExecution = apps.get_model("workflow_v2", "WorkflowExecution")
    WorkflowExecution.objects.update(organization=None)


class Migration(migrations.Migration):
    dependencies = [
        ("workflow_v2", "0018_add_organization_to_workflow_execution"),
    ]

    operations = [
        migrations.RunPython(
            populate_organization_field,
            reverse_populate_organization_field,
        ),
    ]