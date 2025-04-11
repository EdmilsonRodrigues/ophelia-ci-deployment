terraform {
  required_providers {
    lxd = {
        source = "terraform-lxd/lxd"
    }
  }
}

resource "lxd_profile" "ophelia_ci" {
  name = "ophelia_ci"

  config = {
    "boot.autostart" = "true"
    "linux.kernel_modules" = "ip_vs,ip_vs_rr,ip_vs_wrr,ip_vs_sh,ip_tables,ip6_tables,netlink_diag,nf_nat,overlay,br_netfilter"
    "raw.lxc" = "lxc.apparmor.profile=unconfined lxc.mount.auto=proc:rw sys:rw cgroup:rw lxc.cgroup.devices.allow=a lxc.cap.drop="
    "security.nesting" = "true"
    "security.privileged" = "true"
  }

  device {
    type = "disk"
    name = "aadisable"

    properties = {
      source  = "/sys/module/nf_conntrack/parameters/hashsize"
      path    = "/sys/module/nf_conntrack/parameters/hashsize"
    }
  }

  device {
    type = "unix-char"
    name = "aadisable2"

    properties = {
      path    = "/dev/kmsg"
      source  = "/dev/kmsg"
    }
  }

  device {
    name = "aadisable3"
    type = "disk"

    properties = {
      path    = "/sys/fs/bpf"
      source  = "/sys/fs/bpf"
    }
  }

  device {
    name = "aadisable4"
    type = "disk"

    properties = {
      path    = "/proc/sys/net/netfilter/nf_conntrack_max"
      source  = "/proc/sys/net/netfilter/nf_conntrack_max"
    }
  }

  device {
    name = "root"
    type = "disk"

    properties = {
      path = "/"
      pool = "default"
    }
  }  

  device {
    name = "eth0"
    type = "nic"

    properties = {
        nictype = "bridged"
        parent = "${lxd_network.ophelia.name}"
    }
  }
}

resource "lxd_network" "ophelia" {
    name = "ophelia"

    config = {
        "ipv4.address"  = "10.150.19.1/24"
        "ipv4.nat"      = "true"
        "ipv6.address"  = "fd42:474b:622d:259d::1/64"
        "ipv6.nat"      = "true"
    }
  
}

resource "lxd_instance" "base" {
  name      = var.container_name
  image     = var.container_image
  profiles  = var.container_profiles
  ephemeral = false
}
