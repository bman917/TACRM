#!/bin/bash
rake db:migrate && rake assets:precompile && rails s