# Multi-stage docker build
# Build stage
FROM golang:1.18 AS builder

ARG TARGETOS=linux
ARG TARGETARCH

ADD . /litmus-go
WORKDIR /litmus-go

RUN export GOOS=${TARGETOS} && \
    export GOARCH=${TARGETARCH}

RUN CGO_ENABLED=0 go build -o /output/experiments ./cmd/kube-burner

# Deploy stage
FROM registry.fedoraproject.org/fedora-minimal:latest
RUN microdnf install rsync -y && rm -Rf /var/cache/yum
COPY --from=builder /output/ /bin
COPY examples/workloads/kubelet-density/templates/pod.yml /templates/pod.yml 
LABEL io.k8s.display-name="kube-burner" \
      maintainer="Raul Sevilla <rsevilla@redhat.com"
ENTRYPOINT ["/bin/kube-burner"]
