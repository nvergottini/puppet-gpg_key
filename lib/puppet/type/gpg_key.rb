Puppet::Type.newtype(:gpg_key) do

  desc <<-EOT

  EOT

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:path) do
    desc 'The file Puppet will ensure is imported.'
    
    isnamevar
    
    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end
  end

  # Autorequire the file resource if it's being managed
  autorequire(:file) do
    self[:path]
  end
end
