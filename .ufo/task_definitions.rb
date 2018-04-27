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
    # Comment out awslogs_* if you do not want logs to be sent to CloudWatch.
    # Strongly recommended to use CloudWatch/centralized logging.
    # Ufo automatically creates the log group as part of deployment.
    #
    # More info on awslogs settings: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_awslogs.html
    # The log stream takes the following format:
    #   prefix-name/container-name/ecs-task-id
    # Here's an exmaple when you specify the prefix of "demo"
    #   demo/web/209e93b4-5523-4496-9a27-662fd151eb78
    awslogs_group: "ecs/deal_app_web",
    awslogs_stream_prefix: "deal_app",
    awslogs_region: helper.current_region,
    command: ["bin/web"]
  )
end

