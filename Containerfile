FROM registry.fedoraproject.org/fedora-minimal:latest
RUN microdnf install rsync -y && rm -Rf /var/cache/yum
COPY bin/amd64/kube-burner /bin/kube-burner
COPY examples/workloads/kubelet-density/templates/pod.yml /templates/pod.yml 
LABEL io.k8s.display-name="kube-burner" \
      maintainer="Raul Sevilla <rsevilla@redhat.com"
ENTRYPOINT ["/bin/kube-burner"]
