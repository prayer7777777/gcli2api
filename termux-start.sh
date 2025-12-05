echo "强制同步项目代码，忽略本地修改..."
git fetch --all
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)

echo "初始化 Python 虚拟环境..."
if [ ! -d ".venv" ]; then
    python -m venv .venv
fi

echo "激活虚拟环境并安装依赖..."
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements-termux.txt

echo "使用 pm2 启动服务..."
pm2 start .venv/bin/python --name web -- web.py