resource "google_access_context_manager_access_policy" "platform" {
  parent = "organizations/${var.org_id}"
  title  = "platform-policy"
}
