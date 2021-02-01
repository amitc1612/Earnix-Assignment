# Earnix Assignment
* Author: Amit Cohen

First of all, this was my first time deeply understanding the fundamentals of Terraform, ALB and Lambda.
This project isn't really ready for deployment, but rather a blueprint with room for improvement.

### Application Load Balancer - Listener Rules
I have decided to direct all incoming traffic (earnix-example.com) to the EC2 instances, and a specific path to access the lambda function (earnix-example.com/time). 
```HCL
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
```

### How will I secure the app?
I would change the listening port on the Load Balancer to 443 (HTTPS), using a SSL certificate.

### How will I authenticate users?
I would integrate the use of a database to store user data (MongoDB or MySQL), but also offer a SSO service (OpenID) for easy and secure authentication.