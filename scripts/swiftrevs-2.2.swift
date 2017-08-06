import Glibc

extension String {
  subscript (r: Range<Int>) -> String {
    get {
      let startIndex = self.startIndex.advancedBy(r.startIndex)
      let endIndex   = self.startIndex.advancedBy(r.endIndex)
            
      return self[Range(start: startIndex, end: endIndex)]
    }
  }
}

// Yes, this code needs to be tightened.

func getGitRevision(dirname:String) -> String {
  let BUFSIZE = 128
  let cwd     = String.fromCString(getcwd(nil, 0))!
  let rc      = chdir(dirname)

  guard rc == 0 else {
    return "ERROR"
  }

  var rev  = ""
  let pipe = popen("/usr/bin/git rev-parse HEAD", "r")
  var buf  = [CChar](count:BUFSIZE, repeatedValue:CChar(0))
  while fgets(&buf, Int32(BUFSIZE), pipe) != nil {
    rev = String.fromCString(buf)!
  }

  rev = rev[0...9]
  chdir(cwd)
  return rev
}

func getGitFetchURL(dirname:String) -> String {
  let BUFSIZE = 128
  let cwd     = String.fromCString(getcwd(nil, 0))!
  let rc      = chdir(dirname)
  
  guard rc == 0 else {
    return "ERROR"
  }
  
  var url  = ""
  let pipe = popen("/usr/bin/git remote show origin -n|grep Fetch| echo -n `cut --characters=14-`", "r")
  var buf  = [CChar](count:BUFSIZE, repeatedValue:CChar(0))
  while fgets(&buf, Int32(BUFSIZE), pipe) != nil {
    url = String.fromCString(buf)!
  }

  chdir(cwd)

  return url
}

func getGitBranch(dirname:String) -> String {
  let BUFSIZE = 128
  let cwd     = String.fromCString(getcwd(nil, 0))!
  let rc      = chdir(dirname)
  
  guard rc == 0 else {
    return "ERROR"
  }
  
  var url  = ""
  let pipe = popen("/usr/bin/git branch | echo -n `cut --characters=2-`", "r")
  var buf  = [CChar](count:BUFSIZE, repeatedValue:CChar(0))
  while fgets(&buf, Int32(BUFSIZE), pipe) != nil {
    url = String.fromCString(buf)!
  }

  chdir(cwd)

  return url
}

let dirs = ["swift", "llvm", "clang", "compiler-rt", "lldb", "cmark", "llbuild", "swiftpm", "swift-corelibs-xctest", "swift-corelibs-foundation", "swift-integration-tests", "swift-corelibs-libdispatch"]

print("Repository,URL,Branch,Revision")
for dir in dirs {
  let fetch = getGitFetchURL(dir)
  let rev = getGitRevision(dir)
  let branch = getGitBranch(dir)
  print("\(dir),\(fetch),\(branch),\(rev)")
}
