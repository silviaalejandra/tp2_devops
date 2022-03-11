#!/bin/bash

ansible-playbook -i hosts -l controller setup_controller.yaml -v