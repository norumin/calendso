resource "google_project_service" "calendar" {
  project = google_project.main.project_id
  service = "calendar-json.googleapis.com"
}

resource "google_project_service" "crm" {
  project = google_project.main.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "idp" {
  project = google_project.main.project_id
  service = "identitytoolkit.googleapis.com"
}

resource "google_project_service" "serviceusage" {
  project = google_project.main.project_id
  service = "serviceusage.googleapis.com"
}
