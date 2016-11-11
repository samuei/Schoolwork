
using namespace std;

// Default constructor. Probably shouldn't ever be needed.
node::node()
{
  num = -1;
  parent = this;
  rank = -1;
}

// The constructor you're actually looking for.
node::node(int number)
{
  // The vertex #
  num = number;
  parent = this;
  rank = 0;
}

// Default destructor
node::~node()
{

}

// Get the root of this node's tree
node* node::find()
{
  // If this isn't the root, make the parent the root
  if (this->parent != this && this->parent != nullptr)
    {
      this->parent = this->parent->find();
    }

  // Now that we know the parent is the root, return that sucker
  return this->parent;
}

// merge two trees by rank
// if true, union complete. If false, same tree, no union.
bool node::unionbyr(node* x, node* y)
{
  node* otherroot = x->find();
  node* root = y->find();
  if (root == otherroot)
    {
      // If you're here, you've tried to merge two members of the same tree
      return false;
    }
  else 
    {
      if (root->rank < otherroot->rank)
	{
	  root->parent = otherroot;
	}
      else if (root->rank > otherroot->rank)
	{
	  otherroot->parent = root;
	}
      else
	{
	  otherroot->parent = root;
	  otherroot->rank += 1;
	}
      return true;
    }
}
