require 'facter'

csr_domains = Dir['/etc/pki/tls/csr/*.csr'].map { |a| a.gsub(%r{\.csr$}, '').gsub(%r{^.*/}, '') }

Facter.add(:csr_cns) do
  setcode do
    csr_domains.join(',') if csr_domains
  end
end

csr_domains.each do |csr_domain|
  Facter.add('acme_csr_' + csr_domain) do
    setcode do
      csr = File.read("/etc/pki/tls/csr/#{csr_domain}.csr")
      csr
    end
  end
end
