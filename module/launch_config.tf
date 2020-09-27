resource "aws_launch_configuration" "kube_etcd_lc" {
  name_prefix          = "kube_etcd_lc-"
  image_id             = "${var.kube_etcd_ami}"
  instance_type        = "${var.kube_etcd_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.kube_etcd_instance_profile.id}"
  key_name             = "${var.key_pair}"
  user_data            = "${data.template_file.user-init-kube-etcd.rendered}"
  security_groups      = ["${var.kube_sg_id}", ]

  lifecycle {
    create_before_destroy = true
  }
}
