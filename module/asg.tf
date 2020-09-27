resource "aws_autoscaling_group" "kube_etcd_asg" {
  name                      = "kube_etcd_asg"
  max_size                  = 6
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = "${var.etcd_desired_capacity}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.kube_etcd_lc.id}"

  vpc_zone_identifier = ["${var.private_subnet1}",
  "${var.private_subnet2}"]
  
lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "kube_etcd"
    propagate_at_launch = true
  }
}
