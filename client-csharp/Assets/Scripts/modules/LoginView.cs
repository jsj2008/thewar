﻿using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;

namespace Engine
{
	public class LoginContext : BaseContext
	{
		public LoginContext() : base(UIType.Login)
		{

		}
	}

	public class LoginView : BaseView
	{

		[SerializeField]
		private Button _buttonOption;

		public override void OnEnter(BaseContext context)
		{
			Debug.Log ("on enter");
            Button btn = _buttonOption.GetComponent<Button>();
            btn.onClick.AddListener(LoginCallBack);
        }

		public override void OnExit(BaseContext context)
		{
            gameObject.SetActive(false);
            Debug.Log ("on exist");
		}

		public override void OnPause(BaseContext context)
		{
			Debug.Log ("on pause");
            gameObject.SetActive(false);
        }

		public override void OnResume(BaseContext context)
		{
			Debug.Log ("on resume");
		}


        public void LoginCallBack()
        {
            Debug.Log("on button click");
            SceneMgr.Instance.Init();
        }
	}
}
