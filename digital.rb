class Digital < Formula
  desc "Digital logic designer and circuit simulator"
  homepage "https://github.com/hneemann/Digital"
  head "https://github.com/hneemann/Digital.git", :shallow => false

  depends_on :java => "1.7+"
  depends_on "maven" => :build

  def install
    # https://stackoverflow.com/a/53016532 but can't fix test error
    ENV["_JAVA_OPTIONS"] += " -Djdk.net.URLClassPath.disableClassPathURLCheck=true"
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
