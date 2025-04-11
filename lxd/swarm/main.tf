module "ophelia_ci_docker_swarm" {
  source = "../modules/lxd_container_base"

  container_name = "ophelia-ci-docker-swarm"
}
