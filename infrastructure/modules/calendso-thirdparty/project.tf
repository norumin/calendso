resource "google_project" "main" {
  name       = var.app
  project_id = var.gcp_project_id
  org_id     = var.gcp_org_id
}
