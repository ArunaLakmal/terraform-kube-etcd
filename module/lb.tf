resource "aws_lb" "int_kube_etcd_lb" {
  name               = "kubeetcd-int-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${var.private_subnet1}",
  "${var.private_subnet2}"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "int_kube_etcd_tg" {
  name     = "int-kube-etcd-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "int_kube_etcd_listener" {
    load_balancer_arn = "${aws_lb.int_kube_etcd_lb.arn}"
    port = "80"
    protocol = "TCP"

    default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.int_kube_etcd_tg.arn}"
  }
}

resource "aws_autoscaling_attachment" "int_lb-kube_etcd_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.kube_etcd_asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.int_kube_etcd_tg.id}"
}