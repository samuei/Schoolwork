krus::krus()
{

}

krus::krus(int numelements)
{
  base = numelements;
  edges = new edge[base*base];
  nodes = new node*[base];
  for (int i = 0; i<base;i++)
    {
      nodes[i] = new node(i);
    }
  numdone = 0;
}

krus::~krus()
{

}

void krus::init(string costs)
{
  int temp;
  stringstream ss(costs);
  for(int i = 0; i<base; i++)
    {
      ss >> temp;
      edges[(numdone * base)+i] = edge(nodes[numdone], nodes[i], temp);
    }
  numdone += 1;
}

void krus::sort()
{
  // only runs if you're done with init, because no. Just no.
  if (numdone == base)
    {
      // screw it all, insertion sort
      for (int i = 1;i< base*base;i++)
	{
	  edge temp = edge(edges[i].v1,edges[i].v2,edges[i].value);
	  int j = i;
	  while (j>0 && edges[j-1].value > temp.value)
	    {
	      edges[j].value = edges[j-1].value;
	      edges[j].v1 = edges[j-1].v1;
	      edges[j].v2 = edges[j-1].v2;
	      j = j-1;
	    }
	  edges[j].value = temp.value;
	  edges[j].v1 = temp.v1;
	  edges[j].v2 = temp.v2;
	}
    }
}

void krus::kruskal()
{
  sort();
  int edgesfound = 0;
  int cur = 0;
  while(edgesfound < base && cur < (base*base))
    {
      if(edges[cur].value != 0)
	{
	  if(edges[cur].v1->unionbyr(edges[cur].v1, edges[cur].v2))
	    {
	      edgesfound++;
	      edges[cur].print();
	      if (edgesfound < base-1)
		{
		  cout << ", ";
		}
	    }
	}
      cur++;
    }
  cout << endl;
}
