#!/usr/bin/env bats

@test "postfix should be running" {
  ps axu | grep -q 'postfi[x]'
}

@test "postconf should run without errors" {
  /usr/sbin/postconf > /dev/null
}

@test "should be able to login using submission (plain)" {
  /opt/chef/embedded/bin/ruby "${BATS_TEST_DIRNAME}/helpers/submission-plain.rb"
}

@test "should be able to receive mails through smtp" {
  FINGERPRINT="G27XB6yIyYyM99Tv8UXW$(date +%s)"
  TIMEOUT='30'
  MAIL_DIR='/var/vmail/foobar.com/postmaster/new'
  /opt/chef/embedded/bin/ruby "${BATS_TEST_DIRNAME}/helpers/smtp-send.rb" "${FINGERPRINT}"
  i='0'
  while [ "${i}" -le "${TIMEOUT}" ] \
    && ! ( [ -e "${MAIL_DIR}/" ] && grep -qF "${FINGERPRINT}" "${MAIL_DIR}"/* )
  do
    [ "${i}" -gt '0' ] && sleep 1
    i="$((i+1))"
  done
  grep -qF "${FINGERPRINT}" "${MAIL_DIR}"/*
}

