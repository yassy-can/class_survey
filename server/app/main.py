from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
# app.mount("/", StaticFiles(directory="build/web", html=True), name="static")
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

@app.get("/")
async def read_root():
    return [{"message": "hello world"}]

@app.get("/items/")
async def read_items():
    return [{"id": 1, "name": "Item test"}, {"id": 2, "name": "Item 2"}]

@app.post("/items/")
async def create_item(item: Item):
    return item
