def get_python_version(executable)
  if Facter::Util::Resolution.which(executable)
    results = Facter::Util::Resolution.exec("#{executable} -V 2>&1").match(/^.*(\d+\.\d+\.\d+\+?)$/)
    if results
      results[1]
    end
  end
end

Facter.add("python_version") do
  setcode do
    get_python_version 'python'
  end
end