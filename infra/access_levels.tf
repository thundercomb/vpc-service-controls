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
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/accessLevels/orchestration_cloud_build"
  title  = "orchestration-cloud-build"
  basic {
    conditions {
      members = [
        "serviceAccount:${var.orchestration_project_number}@cloudbuild.gserviceaccount.com"
      ]
    }
  }

  depends_on = [google_access_context_manager_access_policy.platform]
}

resource "google_access_context_manager_access_level" "analytics_appengine" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/accessLevels/analytics_appengine"
  title  = "analytics-appengine"
  basic {
    conditions {
      members = [
        "serviceAccount:${var.analytics_project_id}@appspot.gserviceaccount.com"
      ]
    }
  }

  depends_on = [google_access_context_manager_access_policy.platform]
}

resource "google_access_context_manager_access_level" "analytics_ai_platform" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/accessLevels/analytics_ai_platform"
  title  = "analytics-ai-platform"
  basic {
    conditions {
      members = [
        "serviceAccount:service-${var.analytics_project_id}@cloud-ml.google.com.iam.gserviceaccount.com
      ]
    }
  }

  depends_on = [google_access_context_manager_access_policy.platform]
}
