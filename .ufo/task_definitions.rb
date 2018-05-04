# There some built-in helpers that are automatically available in this file.
#
# Some of helpers get data from the Dockerfile and some are from other places.
# Here's a summary of the some helpers:
#
#   helper.full_image_name 
#   helper.dockerfile_port
#   helper.env_vars(text)
#   helper.env_file(path)
#   helper.current_region
#
# More info: http://ufoships.com/docs/helpers/
#
task_definition "deal_app_web" do
  source "main" # will use ufo/templates/main.json.erb
  variables(
    family: task_definition_name,
    name: "web",
    container_port: helper.dockerfile_port,
    awslogs_group: "ecs/deal_app_web",
    awslogs_stream_prefix: "deal_app",
    awslogs_region: helper.current_region,
    command: ["bin/web"]
  )
end
