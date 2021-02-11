/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> {{.Provider.version}}"
    }
  }
}

provider "google" {
  {{if .Provider.credentials }}credentials = "{{.Provider.credentials}}"{{end}}
}

resource "google_bigquery_table" "default" {
  dataset_id = "test-dataset"
  table_id   = "test-table"

  description = "test description"
  expiration_time = 100
  
  encryption_configuration {
    kms_key_name = "projects/{{.Provider.project}}/locations/australia-southeast1/keyRings/default_kms_keyring_name/cryptoKeys/default_kms_key_name"
  }

  time_partitioning {
    type = "DAY"
    expiration_ms = 3600000
  }

  labels = {
    test-key = "test-alue"
  }
}
