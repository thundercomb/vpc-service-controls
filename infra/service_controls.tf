resource "google_access_context_manager_access_policy" "platform" {
  parent = "organizations/${var.org_id}"
  title  = "platform-policy"
}

resource "google_access_context_manager_access_level" "default" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/accessLevels/default"
  title  = "default"
  basic {
    conditions {
      ip_subnetworks = [
        "${var.inception_ip}"
      ]
    }
  }

  depends_on = [google_access_context_manager_access_policy.platform]
}


resource "google_access_context_manager_service_perimeter" "orchestration" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/servicePerimeters/orchestration"
  title  = "orchestration"
  status {
    restricted_services = local.restricted_services
  }

  depends_on = [
    google_access_context_manager_access_policy.platform,
    google_access_context_manager_access_level.default
  ]
}

resource "google_access_context_manager_service_perimeter" "analytics" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/servicePerimeters/analytics"
  title  = "analytics"
  status {
    restricted_services = local.restricted_services
  }

  depends_on = [
    google_access_context_manager_access_policy.platform,
    google_access_context_manager_access_level.default
  ]
}

resource "google_access_context_manager_service_perimeter" "orchestration_analytics_bridge" {
  parent         = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name           = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/servicePerimeters/orchestration_analytics_bridge"
  title          = "orchestration_analytics_bridge"
  perimeter_type = "PERIMETER_TYPE_BRIDGE"

  depends_on = [
    google_access_context_manager_service_perimeter.orchestration,
    google_access_context_manager_service_perimeter.analytics,
  ]
}
