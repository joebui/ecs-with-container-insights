#!/bin/bash

echo "ECS_CLUSTER=${cluster}" >>/etc/ecs/ecs.config
echo "ECS_ENABLE_SPOT_INSTANCE_DRAINING=true" >>/etc/ecs/ecs.config

systemctl restart docker
