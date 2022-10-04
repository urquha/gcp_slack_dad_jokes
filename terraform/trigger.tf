resource "google_pubsub_topic" "dad_joke_trigger_hourly" {
  name = "dad-joke-trigger-hourly"
}

resource "google_cloud_scheduler_job" "hourly" {
  name        = "dad-joke-hourly-min-trigger"
  description = "Scheduled houly to trigger cloud function getting dad joke and posting to slack"
  schedule    = "0 * * * *"

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.dad_joke_trigger_hourly.id
    data       = base64encode("5min")
  }
}