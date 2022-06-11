function switch_arch
  alias x64='exec arch -x86_64 /opt/homebrew/bin/fish'
  alias a64='exec arch -arm64e /opt/homebrew/bin/fish'

  if test (uname -m) = "arm64"
    set arch x86_64
    exec arch -arch $arch /bin/zsh
  else if test (uname -m) = "x86_64"
    set arch arm64e
    exec arch -arch $arch /opt/homebrew/bin/fish
  end
end
