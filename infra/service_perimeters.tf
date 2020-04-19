resource "google_access_context_manager_service_perimeter" "orchestration" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/servicePerimeters/orchestration"
  title  = "orchestration"
  status {
    restricted_services = local.restricted_services
    resources = [
      "projects/${var.orchestration_project_number}"
    ]
    access_levels = [
      google_access_context_manager_access_level.default.name,
      google_access_context_manager_access_level.orchestration_cloud_build.name
    ]
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
    resources = [
      "projects/${var.analytics_project_number}"
    ]
    access_levels = [
      google_access_context_manager_access_level.default.name,
      google_access_context_manager_access_level.orchestration_cloud_build.name,
      google_access_context_manager_access_level.analytics_appengine.name,
      google_access_context_manager_access_level.analytics_ai_platform.name
    ]
  }

  depends_on = [
    google_access_context_manager_access_policy.platform,
    google_access_context_manager_access_level.default,
    google_access_context_manager_access_level.orchestration_cloud_build,
    google_access_context_manager_access_level.analytics_appengine,
    google_access_context_manager_access_level.analytics_ai_platform
  ]
}

# resource "google_access_context_manager_service_perimeter" "orchestration_analytics_bridge" {
#   parent         = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
#   name           = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/servicePerimeters/orchestration_analytics_bridge"
#   title          = "orchestration-analytics-bridge"
#   perimeter_type = "PERIMETER_TYPE_BRIDGE"
#
#   depends_on = [
#     google_access_context_manager_service_perimeter.orchestration,
#     google_access_context_manager_service_perimeter.analytics,
#   ]
# }
