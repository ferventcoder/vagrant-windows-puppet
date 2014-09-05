class reboot {
  notify { 'now':
  } ~>
  reboot { 'now':
  }
}

include reboot
