resource "google_storage_bucket" "function_bucket" {
    name     = "${var.project}-dad-jokes-function"
    location = var.region
}

resource "google_storage_bucket" "input_bucket" {
    name     = "${var.project}-dad-jokes-input"
    location = var.region
}