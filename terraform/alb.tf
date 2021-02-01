resource "aws_lb" "app" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.lb_security_group.this_security_group_id]
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2.arn
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.app.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2.arn
  }
  condition {
    host_header {
      values = ["earnix-example.com"]
    }
  }
}

resource "aws_lb_listener_rule" "secondary" {
  listener_arn = aws_lb_listener.app.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda.arn
  }
  condition {
    path_pattern {
      values = ["/time/*"]
    }
  }
}
