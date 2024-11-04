from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
#model
from app.db import session
from app.fruit import *

app = FastAPI()
# app.mount("/static", StaticFiles(directory="../client/build/web", html=True), name="static")
# app.mount("/client", StaticFiles(directory="client"))

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 必要に応じて特定のオリジンを指定
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Item(BaseModel):
    id: int
    name: str

# @app.get("/favicon.ico", include_in_schema=False)
# async def favicon():
#     return RedirectResponse(url="/static/favicon.ico")

@app.get("/")
async def read_root():
    return [{"message": "hello world"}]

@app.get("/items/")
async def read_items():
    try:
        # データを取得
        fruits = session.query(Fruit).all()
        # return [fruit.json_object() for fruit in fruits]
        # fruitsがリストとして返ってくる部分を修正
        first_fruit = fruits[0] if fruits else None  # フルーツが存在するか確認
        print("first_fruit",first_fruit)
        return first_fruit.json_object() if first_fruit else {"error": "No fruits found"}
        
    finally:
        print("データを取得した")
    # return {}

@app.post("/items/")
async def create_item(item: Item):
    return item
