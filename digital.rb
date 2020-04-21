class Digital < Formula
  desc "Digital logic designer and circuit simulator"
  homepage "https://github.com/hneemann/Digital"
  url "https://github.com/hneemann/Digital.git", :tag => "v0.24"

  head do
    url "https://github.com/hneemann/Digital.git", :shallow => false
  end

  depends_on :java => "1.7+"

  def install
    system "mvn", "package"

    (libexec/"bin").install "target/Digital.jar"
    (bin/"Digital").write <<~EOS
    #!/bin/bash
    exec java -jar "#{libexec}/bin/Digital.jar"
    EOS
    chmod 0555, bin/"Digital"
  end

  test do
    system "mvn", "test"
  end
end
