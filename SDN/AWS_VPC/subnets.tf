resource "aws_subnet" "public" {
    vpc_id      = aws_vpc.main.id
}