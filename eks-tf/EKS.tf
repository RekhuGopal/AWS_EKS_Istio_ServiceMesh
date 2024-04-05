resource "aws_iam_role" "demo" {
  name = "eks-istio-servicemesh-demo"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = "demo"
  version  = "1.29"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_us_west_2a.id,
      aws_subnet.private_us_west_2b.id,
      aws_subnet.public_us_west_2a.id,
      aws_subnet.public_us_west_2b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo_amazon_eks_cluster_policy]
}
