https://blog.cloudtechner.com/setting-up-efs-as-persistent-volume-for-aws-eks-d16f5f46951e

fsid: fs-049f4e18a1b6a7d09
subnetid: subnet-081f6456dbceb3c42
sgid: sg-0b69e7339d666dc40
cidr: 192.168.0.0/16
vpcid: vpc-00f5052c1855c5a5c
accountid: 524756828598

aws iam create-policy `
    --policy-name AmazonEKS_EFS_CSI_Driver_Policy `
    --policy-document file://iam-policy-example.json

aws iam create-role `
  --role-name AmazonEKS_EFS_CSI_DriverRole `
  --assume-role-policy-document file://"trust-policy.json"    

aws iam attach-role-policy `
  --policy-arn arn:aws:iam::524756828598:policy/AmazonEKS_EFS_CSI_Driver_Policy `
  --role-name AmazonEKS_EFS_CSI_DriverRole