resource "google_access_context_manager_access_level" "default" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/accessLevels/default"
  title  = "default"
  basic {
    conditions {
      ip_subnetworks = [
        "${var.inception_ip}"
      ]
      members = [
        "user:${var.inception_user}"
      ]
    }
  }

  depends_on = [google_access_context_manager_access_policy.platform]
}

resource "google_access_context_manager_access_level" "orchestration_cloud_build" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/accessLevels/orchestration-cloud-build"
  title  = "orchestration-cloud-build"
  basic {
    conditions {
      members = [
        "serviceAccount:${var.inception_project_number}@cloudbuild.gserviceaccount.com"
      ]
    }
  }

  depends_on = [google_access_context_manager_access_policy.platform]
}
