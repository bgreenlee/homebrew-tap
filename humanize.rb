class Humanize < Formula
    desc "Convert big numbers to human-readable"
    homepage "https://github.com/bgreenlee/humanize"
    url "https://github.com/bgreenlee/humanize/archive/v1.2.1.tar.gz"
    sha256 "f7808fb543a219c18a49354d60db6e44d22fe2ba2af175aa693f9dd04d1101a9"
  
    depends_on "go"
  
    def install
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "on"
      ENV["GOFLAGS"] = "-mod=vendor"
      ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
      (buildpath/"src/github.com/bgreenlee/humanize").install buildpath.children
      cd "src/github.com/bgreenlee/humanize" do
        system "go", "build", "-o", bin/"humanize", "."
      end
    end
  
    test do
      assert_match /Usage of humanize/, shell_output("#{bin}/humanize -h", 0)
    end
  end