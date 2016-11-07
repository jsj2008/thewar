﻿using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace Engine
{
	public class ContextManager : Singleton<ContextManager>
	{
		private Stack<BaseContext> _contextStack = new Stack<BaseContext>();

		public ContextManager()
		{
			Push(new LoginContext());
		}

		public void Push(BaseContext nextContext)
		{

			if (_contextStack.Count != 0)
			{
				BaseContext curContext = _contextStack.Peek();
				BaseView curView = UIManager.Instance.GetSingleUI(curContext.ViewType).GetComponent<BaseView>();
				curView.OnPause(curContext);
			}

			_contextStack.Push(nextContext);
			BaseView nextView = UIManager.Instance.GetSingleUI(nextContext.ViewType).GetComponent<BaseView>();
			nextView.OnEnter(nextContext);
		}

		public void Pop()
		{
			if (_contextStack.Count != 0)
			{
				BaseContext curContext = _contextStack.Peek();
				_contextStack.Pop();

				BaseView curView = UIManager.Instance.GetSingleUI(curContext.ViewType).GetComponent<BaseView>();
				curView.OnExit(curContext);
			}

			if (_contextStack.Count != 0)
			{
				BaseContext lastContext = _contextStack.Peek();
				BaseView curView = UIManager.Instance.GetSingleUI(lastContext.ViewType).GetComponent<BaseView>();
				curView.OnResume(lastContext);
			}
		}

		public BaseContext PeekOrNull()
		{
			if (_contextStack.Count != 0)
			{
				return _contextStack.Peek();
			}
			return null;
		}
	}
}
