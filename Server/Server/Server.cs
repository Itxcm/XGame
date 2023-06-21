﻿using MVC;
using Server.MVC;
using System.Threading;
using XShare;

namespace Server
{
    internal class Server
    {
        private Thread thread;
        private bool running = false;
        private NetService network;

        public bool Init()
        {
            int Port = Properties.Settings.Default.ServerPort;
            network = new NetService();
            network.Init(Port);

            DBService.Instance.Init();
            UserSerevice.Instance.Init();

            thread = new Thread(new ThreadStart(this.Update));
            return true;
        }

        public void Start()
        {
            network.Start();
            running = true;
            thread.Start();
        }

        public void Stop()
        {
            running = false;
            thread.Join();
            network.Stop();
        }

        public void Update()
        {
            while (running)
            {
                TimeUtil.Tick();
                Thread.Sleep(100);
            }
        }
    }
}