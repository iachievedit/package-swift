import Glibc

extension String {
  subscript (r: Range<Int>) -> String {
    get {
      let startIndex = self.startIndex.advanced(by:r.startIndex)
      let endIndex   = self.startIndex.advanced(by:r.endIndex)
            
      return self[Range(startIndex..<endIndex)]
    }
  }
}

func getGitRevision(directory:String) -> String {
  let BUFSIZE = 128
  let cwd     = String(cString:getcwd(nil, 0))
  let rc      = chdir(directory)
  
  guard rc == 0 else {
    return "ERROR"
  }
  
  var rev  = ""
  let pipe = popen("/usr/bin/git rev-parse HEAD", "r")
  var buf  = [CChar](repeating:CChar(0), count:BUFSIZE)
  while fgets(&buf, Int32(BUFSIZE), pipe) != nil {
    rev = String(cString:buf)
  }
 rev = rev[0...9]

  chdir(cwd)

  return rev
}

let dirs = ["swift", "llvm", "clang", "lldb", "compiler-rt", "cmark", "llbuild", "swiftpm", "swift-corelibs-xctest", "swift-corelibs-foundation", "swift-integration-tests", "swift-corelibs-libdispatch"]

for dir in dirs {
  let rev = getGitRevision(directory:dir)
  print("\(dir):\(rev)")
}
