'''
对爬行任务的封装，支持队列和栈两种模式
'''

class UrlSequence:
 def __init__(self):
  # 经访问过的 URL 列表
  self.visited = []
  # 尚未访问过的 URL 列表
  self.unvisited = []

 # 获得已经访问过的 URL 列表
 def getVisitedUrl(self):
  return self.visited

 # 获得未访问过的 URL 列表
 def getUnvisitedUrl(self):
  return self.unvisited

 # Append 到已经访问过的 URL 列表
 def Visited_Add(self, url):
  self.visited.append(url)

 # 从已经访问过的 URL 列表中删除
 def Visited_Remove(self, url):
  self.visited.remove(url)

 # 从未访问的列表取出 URL（pop--栈方式）
 def Unvisited_Pop(self):
  try:
   return self.unvisited.pop()
  except:
   return None

 # Append 到未访问的 URL 列表
 def Unvisited_Add(self, url):
  if url != "" and url not in self.visited and url not in self.unvisited:
   self.unvisited.append(url)

 # 计数值
 def Visited_Count(self):
  return len(self.visited)

 # 计数值
 def Unvisited_Count(self):
  return len(self.unvisited)

 # 任务是否为空
 def UnvisitedIsEmpty(self):
  return len(self.unvisited) == 0