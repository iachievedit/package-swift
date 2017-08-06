// Copyright 2016 iAchieved.it LLC MIT License
import Glibc

extension String {
  subscript (r: CountableClosedRange<Int>) -> String {
    get {
      let startIndex = self.characters.index(self.characters.startIndex, offsetBy:r.lowerBound)
      let endIndex   = self.characters.index(self.characters.startIndex, offsetBy:r.upperBound)
      return self[startIndex..<endIndex]
    }
  }
}

func exec(_ command:String) -> String {
  let BUFSIZE = 128
  let pipe = popen(command, "r")
  var buf  = [CChar](repeating:CChar(0), count:BUFSIZE)
  var output:String = ""
  while fgets(&buf, Int32(BUFSIZE), pipe) != nil {
    output = String(cString:buf)
  }
  return output
}

func gitRevision() -> String {
  return exec("/usr/bin/git rev-parse HEAD")[0...9]
}

func gitFetchURL() -> String {
  return exec("/usr/bin/git remote show origin -n|grep Fetch| echo -n `cut --characters=14-`")
}

func gitBranch() -> String {
  return exec("/usr/bin/git branch | echo -n `cut --characters=2-`")
}

let dirs = ["swift", "llvm", "clang", "lldb", "compiler-rt", "cmark", "llbuild", "swiftpm", "swift-corelibs-xctest", "swift-corelibs-foundation", "swift-integration-tests", "swift-corelibs-libdispatch"]

for dir in dirs {
  let cwd     = String(cString:getcwd(nil, 0))
  let rc      = chdir(dir) // pushd
  guard rc == 0 else {
    continue
  }
  let fetch  = gitFetchURL()
  let rev    = gitRevision()
  let branch = gitBranch()
  print("\(dir),\(fetch),\(branch),\(rev)")
  chdir(cwd) // popd
}
