from fastapi import FastAPI, File, UploadFile
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import pandas as pd
import io
#model
from app.LMestimation.lmestimation import LMestimation

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


@app.post("/items/")
async def create_item(item: Item):
    return item

@app.post("/upload/")
async def upload_file(file: UploadFile):

    if not file:
        return JSONResponse(content={"message": "ファイルがありません"}, status_code=400)

    # ファイル名を取得してprint
    print(f"受け取ったファイル名: {file.filename}")
    
    # # ファイルの保存（必要な場合）
    # file_location = f"./uploads/{file.filename}"
    # with open(file_location, "wb") as buffer:
    #     buffer.write(await file.read())
    
    return JSONResponse(content={"filename": file.filename, "message": "ファイルを受け取りました"})

@app.post("/upload_csv")
async def upload_csv(file: UploadFile):
    # ファイルが送信されているか確認
    if not file:
        return JSONResponse(content={"message": "ファイルがありません"}, status_code=400)

    # CSVファイルの読み込み
    content = await file.read()
    csv_data = pd.read_csv(io.StringIO(content.decode('utf-8')))

    # CSVの内容をコンソールに表示
    print("受け取ったCSVファイルの内容:")
    print(csv_data)

    result, loadings = LMestimation(csv_data)
    # 5秒の遅延を追加
    # await asyncio.sleep(5)
    
    # JSONレスポンスにCSVの内容を一部返す（先頭5行）
    return JSONResponse(content={"message": "ファイルを受け取りました", "data": result})# , "loadings": loadings})