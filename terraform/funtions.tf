
# Generates an archive of the source code compressed as a .zip file.
data "archive_file" "dad_jokes_slack" {
    type        = "zip"
    source_dir  = "../cloud_function"
    output_path = "/tmp/dad_jokes_slack.zip"
}

# Add source code zip to the Cloud Function's bucket
resource "google_storage_bucket_object" "dad_jokes_slack" {
    source       = data.archive_file.dad_jokes_slack.output_path
    content_type = "application/zip"

    # Append to the MD5 checksum of the files's content
    # to force the zip to be updated as soon as a change occurs
    name         = "cloud_function-${data.archive_file.dad_jokes_slack.output_md5}.zip"
    bucket       = google_storage_bucket.function_bucket.name
}

resource "google_cloudfunctions_function" "dad_jokes_slack" {
    name                  = "dad-jokes-slack"
    runtime               = "python37"  # of course changeable
    timeout               = 540
    # available_memory_mb   = 1024

    # Get the source code of the cloud function as a Zip compression
    source_archive_bucket = google_storage_bucket.function_bucket.name
    source_archive_object = google_storage_bucket_object.dad_jokes_slack.name

    # Must match the function name in the cloud function `main.py` source code
    entry_point           = "main"
    
    event_trigger {
        event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
        resource   = google_pubsub_topic.dad_joke_trigger_hourly.id
    }
    

    secret_environment_variables {
        key = "SLACK_WEBHOOK_URL"
        secret = "SLACK_WEBHOOK_URL"
        version = "latest" 
    }
}

