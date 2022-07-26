provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

resource "mongodbatlas_project" "notestest" {
  # 61ad2bcaf5fc4615cc7a70a0
  name   = "notestest"
  org_id = "5fb95e8c9004e01a4946a5a7"

  is_collect_database_specifics_statistics_enabled = true
  is_data_explorer_enabled                         = true
  is_performance_advisor_enabled                   = true
  is_realtime_performance_panel_enabled            = true
  is_schema_advisor_enabled                        = true
}

resource "mongodbatlas_cluster" "madamas" {
  project_id   = mongodbatlas_project.notestest.id
  name         = "Madamas"
  cluster_type = "REPLICASET"

  mongo_db_major_version = "5.0"

  auto_scaling_disk_gb_enabled = true
  cloud_backup                 = false

  # Provider Settings "block"
  provider_name               = "TENANT"
  provider_region_name        = "EU_CENTRAL_1"
  provider_instance_size_name = "M0"
  disk_size_gb                = 0.5
}
