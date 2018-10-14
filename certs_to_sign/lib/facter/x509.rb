require 'facter'

certs = Dir['/etc/pki/tls/certs/*.crt'].map { |a| a.gsub(%r{\.crt$}, '').gsub(%r{^.*/}, '') }
csrs =  Dir['/etc/pki/tls/csr/*.csr'].map { |a| a.gsub(%r{\.csr$}, '').gsub(%r{^.*/}, '') }

Facter.add(:x509_certs) do
  setcode do
    certs_hash = {}

    certs.each do |cert|
      pem = File.read("/etc/pki/tls/certs/#{cert}.crt")
      certs_hash[cert] = { :crt => pem }
    end
    certs_hash
  end
end

Facter.add(:x509_csrs) do
  setcode do
    csrs_hash = {}
    csrs.each do |req|
      csr = File.read("/etc/pki/tls/csr/#{req}.csr")
      csrs_hash[req] = { :csr => csr }
    end
    csrs_hash
  end
end
