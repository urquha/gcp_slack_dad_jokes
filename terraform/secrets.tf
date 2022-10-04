resource "google_secret_manager_secret" "slack_webhook_url" {
  secret_id = "SLACK_WEBHOOK_URL"
  project = var.project

  replication {
    user_managed {
      replicas {
        location = "europe-west1"
      }
      replicas {
        location = "europe-west2"
      }
    }
  }
}

resource "google_secret_manager_secret_version" "slack_webhook_url" {
  secret = google_secret_manager_secret.slack_webhook_url.id
  secret_data = var.SLACK_WEBHOOK_URL
}

resource "google_secret_manager_secret_iam_binding" "slack_webhook_url" {
  project = var.project
  secret_id = google_secret_manager_secret.slack_webhook_url.secret_id
  role = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${var.project}@appspot.gserviceaccount.com"
  ]
}
