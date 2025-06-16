output "ecr_react_frontend_url" {
  value = module.ecr_react_frontend.repository_url
}

output "ecr_fastapi_url" {
  value = module.ecr_fastapi.repository_url
}

output "ecr_celery_worker_url" {
  value = module.ecr_celery_worker.repository_url
}

output "ecr_celery_beat_url" {
  value = module.ecr_celery_beat.repository_url
}

output "ecr_data_poller_url" {
  value = module.ecr_data_poller.repository_url
}
